import AWS from 'aws-sdk';
import { SendMessageRequest } from 'aws-sdk/clients/sqs';
import { v4 } from 'uuid';

AWS.config.region = 'eu-west-2';

const orderQueue = "https://sqs.eu-west-2.amazonaws.com/401770798620/product-queue-sandbox"

test('should return true', async() => {
    let params: SendMessageRequest = {
        MessageBody: JSON.stringify({
            productId: v4(),
            categoryId: v4(),
            name: 'Make-up',
            status: 'active',
        }),
        QueueUrl: orderQueue
    }

    const data = await (new AWS.SQS()).sendMessage(params).promise()
    console.log(data)
    expect(true).toBe(true)
})
