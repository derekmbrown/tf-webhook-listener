exports.handler = async (event) => {
  // console.log(event);
  console.log(event.requestContext.requestId);

  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ success: true, body: event.body})
  };
};