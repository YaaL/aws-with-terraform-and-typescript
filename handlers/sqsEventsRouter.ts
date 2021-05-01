import { SQSEvent, SQSMessageAttributes } from 'aws-lambda';
import AWS from 'aws-sdk';

AWS.config.region = process.env.AWS_REGION || 'us-east-1'
const eventBridge = new AWS.EventBridge()

export async function sqsEventsRouter (event: SQSEvent) {

    try {
        for (const record of event.Records) {
            const messageAttributes: SQSMessageAttributes = record.messageAttributes;
            console.log('Message Attributtes -->  ', messageAttributes.AttributeNameHere.stringValue);
            console.log('Message Body -->  ', record.body);

            const result = await eventBridge.putEvents({
                Entries: [{
                    EventBusName: 'default',
                    Source: event.Records[0].eventSource,
                    DetailType: 'order',
                    Detail: JSON.stringify(record.body)
                }]
            }).promise()

            console.log("EventBridge putEvnet results" + result);
        }
    } catch (error) {
        console.log(error);
        throw error
    }
  }


exports.handler = sqsEventsRouter
