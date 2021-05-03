import AWS from 'aws-sdk';
import { SendMessageRequest } from 'aws-sdk/clients/sqs';
import { v4 } from 'uuid';

AWS.config.region = 'eu-west-2';

const orderQueue = "https://sqs.eu-west-2.amazonaws.com/401770798620/orders-queue-sandbox"

test('should return true', async() => {
    let params: SendMessageRequest = {
        MessageBody: JSON.stringify({
            orderId: v4(),
            status: 'active',
            totalPrice: 20

        }),
        QueueUrl: orderQueue
    }

    const data = await (new AWS.SQS()).sendMessage(params).promise()
    console.log(data)
    expect(true).toBe(true)
})
