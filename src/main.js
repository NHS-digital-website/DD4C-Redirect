const location = "https://hscic.kahootz.com/connect.ti/t_c_home/view?objectId-777732"
const html = `
<html>
    <head>
    <title>DD4C has moved</title>
    </head>
    <body>
    <h1>DD4C has moved</h1>
    <p>Please go to <a href="${location}">${location}</a>.</p>
    </body>
</html>
`
exports.redirection = async(event) => {
    if(event.headers.integrity !== undefined && process.env.INTEGRITY_CHECK !== undefined) {
        if(event.headers.integrity === process.env.INTEGRITY_CHECK) {
            return {
                statusCode: 200,
                headers: {
                    "Content-Type" : "text/html; charset=UTF-8",
                    "Location" : location
                },
                body: html
            };
        }
    }
	return {
        statusCode: 403,
        headers: {
            "Content-Type" : "text/plain; charset=UTF-8",
        },
        body: "forbidden"
    };
}