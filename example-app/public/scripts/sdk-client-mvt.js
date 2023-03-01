
// function to set a cookie
function setCookie(name, value) {
    const d = new Date();
    d.setTime(d.getTime() + (5 * 60 * 1000)); // expiry time set to 5 minutes
    const expires = d.toUTCString();
    value = encodeURIComponent(value);
    document.cookie = `${name}=${value}; expires=${expires}; path=/`;
}
function getCookie(c_name)
{
   var i,x,y,ARRcookies=document.cookie.split(";");
   for (i=0; i<ARRcookies.length; i++)
   {
      x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
      y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
      x=x.replace(/^\s+|\s+$/g,"");
      if (x==c_name)
      {
        return unescape(y);
      }
   }
}
// function to get a JWT token and set it as a cookie
async function getTokenAndSetCookie() {
    // check if the 'token' cookie already exists and is not expired
    const cookieValue = getCookie("chAppToken");
    const cookieExpiry = getCookie("chAppTokenExpires");

    if (cookieValue && cookieExpiry) {
        const expiryTime = new Date(cookieExpiry).getTime();
        const currentTime = new Date().getTime();
        if (expiryTime > currentTime) {
            return cookieValue;
        }
    }

    // make an API call to get a JWT token
    try {
        const { JWTToken } = await getToken();
        console.log("got new token")
        if (JWTToken) {
            const expiryTime = new Date().getTime() + (5 * 60 * 1000);
            setCookie('chAppToken', JWTToken);
            setCookie('chAppTokenExpires', new Date(expiryTime).toUTCString());
            return JWTToken;
        } else {
            throw new Error('Invalid token format');
        }
    } catch (error) {
        console.error(error)
        throw error;
    }
}

// function to handle a click event
async function loadtoken(event) {
    console.log("refreshing token")
    await getTokenAndSetCookie();
}

