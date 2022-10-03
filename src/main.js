exports.hello = async(event) => {
	console.log(event);
	let response = {
        statusCode: 200,
        headers: {
            "x-custom-header" : "my custom header value"
        },
        body: "hello would!"
    };
    console.log("response: " + JSON.stringify(response))
    return response;
}