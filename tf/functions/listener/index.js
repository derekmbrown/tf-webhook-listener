exports.handler = async (event) => {
  console.log(event);

  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ success: true, body: event.body})
  };
};