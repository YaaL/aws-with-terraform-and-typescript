import { SQSEvent } from 'aws-lambda';
import AWS from 'aws-sdk';

AWS.config.region = process.env.AWS_REGION || 'us-east-1'
const eventBridge = new AWS.EventBridge()

export async function sqsEventsRouter (event: SQSEvent) {
    try {
        for (const record of event.Records) {
            console.log("Recors");
            console.log(record);
            
            console.log("Body");
            console.log(record.body);

            const source = record.eventSource.split(":")
            const result = await eventBridge.putEvents({
                Entries: [{
                    EventBusName: 'default',
                    Source: record.eventSource,
                    DetailType: source[source.length -1],
                    Detail: record.body
                }]
            }).promise()

            console.log("PutEvents Results");
            console.log(result);
        }
    } catch (error) {
        console.log(error);
        throw error
    }
  }


exports.handler = sqsEventsRouter
