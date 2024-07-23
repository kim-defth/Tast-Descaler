// https://docs.aws.amazon.com/lambda/latest/dg/nodejs-handler.html
exports.handler = (event, context, callback) => {
    callback(null, {
        isBase64Encoded: false,
        body: JSON.stringify(
            { 
                message: "Hello from Lambda"
            }
        ),
        headers: {
            'Access-Control-Allow-Origin': '*'
        },
        statusCode: 200,
    });
}