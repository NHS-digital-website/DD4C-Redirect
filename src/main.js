const newLocation = "https://hscic.kahootz.com/connect.ti/t_c_home/view?objectId-777732"
const htmlTemplate = `
<html>
    <head>
    <title>DD4C has moved</title>
    </head>
    <body>
    <h1>DD4C has moved</h1>
    <p>Please go to <a href="${newLocation}">${newLocation}</a>.</p>
    </body>
</html>
`
const html404Template = `
<html>
    <head>
    <title>404 Page Not Found</title>
    </head>
    <body>
    <h1>404 Page Not Found</h1>
    <p>Are you looking for <a href="${newLocation}">${newLocation}</a>?</p>
    </body>
</html>
`

/**
 * Checks the request came via CloudFront
 * @param {event} event 
 * @returns true if the integrity does not match
 */
function theRequestDoesNotHaveIntegrity(event) {
    return event.headers.integrity === undefined || (event.headers.integrity !== process.env.INTEGRITY_CHECK)
}

/**
 * Check request is for the path
 * @param {event} event
 * @returns true if the path is not in "/", "/dd4c", "/dd4c/"" or "/dd4c?foo=bar"
 */ 
function theRequestDoesNotHaveTheCorrectPath(event) {
    let subject = event.rawPath.split("?")[0].replace(new RegExp("/", "g"), "")
    return !(subject === "dd4c" || subject === "")
}

exports.redirection = async(event) => {
    if(theRequestDoesNotHaveIntegrity(event)) {
        return {
            statusCode: 403,
            headers: {
                "Content-Type" : "text/plain; charset=UTF-8"
            },
            body: "forbidden"
        }
    }
    if(theRequestDoesNotHaveTheCorrectPath(event)) {
        return {
            statusCode: 404,
            headers: {
                "Content-Type" : "text/html; charset=UTF-8"
            },
            body: html404Template
        }
    }
    return {
        statusCode: 302,
        headers: {
            "Content-Type" : "text/html; charset=UTF-8",
            "Location" : newLocation
        },
        body: htmlTemplate
    }
}