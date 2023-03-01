
//* async fn calls internal---------------------------------------------------------------
const pendingResponseCollection = [];
 const getToken = async () => {
  console.log("getToken: making Ajax call")
  return await makeAjaxCall("USER_DATA");
};
function uuidv4() {
  return Date.now() + Math.random();
}

function configure_auth_for_mvt(){
    // get all 'a' elements
    const links = document.querySelectorAll('a');

    // add click event listener to each 'a' element
    links.forEach(link => {
        link.addEventListener('click', function() {

        });
    });
}

function on_all_mvt_page_load_events()  {
    promise =  getToken();
    promise.resolve()
}


//client to wire web calling function
function makeAjaxCall(command) {
  const guid = uuidv4().toString();

  let resolver;
  const promise = new Promise((resolve, reject) => {
    resolver = (message) => {
      message.error ? reject(message) : resolve(message);
    };
  });

  //add the unresolved promise to array of promises
  pendingResponseCollection.push({ guid, resolver });

  //send message to Parent
  window.parent.postMessage({ command, guid, source: "cohesive" }, "*");

  return promise;
}

//* parent message handler
function responseFromMobileClient(e) {
  const response = e.data;
  if (response.source === "cohesive") {
    //find the request we should respond to
    const responseItem = pendingResponseCollection.find(
      (element) => element.guid === response.guid
    );
    //respond
    if (responseItem) responseItem.resolver(response.data);

    //remove the pending call
    if (responseItem) {
      const index = pendingResponseCollection.indexOf(responseItem);
      if (index > -1) pendingResponseCollection.splice(index, 1);
    }
  }
}

//* page sync internal---------------------------------------------------------------
const pageSyncSetup = () => {
  let previousUrl = "";
  const observer = new MutationObserver(function (mutations) {
    if (location.href !== previousUrl) {
      const message = JSON.stringify({
        source: "cohesive",
        event: "path-updated",
        data: {
          oldUrl: previousUrl,
          newUrl: location.href,
          newPath: location.pathname,
        },
      });
      previousUrl = location.href;
      //* make sure to add cross site restriction for communication
      window.parent.postMessage(message, "*");
    }
  });
  return observer;
};

//!fires on load
const init = () => {
  //* parent msg handler
  window.addEventListener("message", responseFromMobileClient);
  //* fetch/axios override
  // onLoadHandler();
  //* page sync init
  const observer = pageSyncSetup();
  const config = { subtree: true, childList: true };
  observer.observe(document, config);
};

const destroy = () => {
  //* parent msg handler
  window.removeEventListener("message", responseFromMobileClient);
};

if (typeof window !== "undefined") {
  window.addEventListener("load", init);
  window.addEventListener("unload", destroy);
}

const getUserData = async () => {
  const { JWTToken } = await getToken();
  return JSON.parse(Buffer.from(JWTToken.split(".")[1], "base64").toString());
};
