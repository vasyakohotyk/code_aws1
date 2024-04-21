exports.handler = (event, context, callback) => {
    const params = {
      Key: {
        id: {
          S: event.id
        }
      },
      UpdateExpression: 'SET title = :title, watchHref = :watchHref, authorId = :authorId, #len = :length, category = :category',
      ExpressionAttributeValues: {
        ':title': { S: event.title },
        ':watchHref': { S: event.watchHref },
        ':authorId': { S: event.authorId },
        ':length': { S: event.length },
        ':category': { S: event.category }
      },
      ExpressionAttributeNames: {
        '#len': 'length'
      },
      TableName: process.env.TABLE_NAME
    };
  
    dynamodb.updateItem(params, (err, data) => {
      if (err) {
        console.log(err);
        callback(err);
      } else {
        callback(null, {
          id: params.Key.id.S,
          title: event.title,
          watchHref: event.watchHref,
          authorId: event.authorId,
          length: event.length,
          category: event.category
        });
      }
    });
  };
  