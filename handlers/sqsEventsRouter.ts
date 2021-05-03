import { SQSEvent } from 'aws-lambda';
import AWS from 'aws-sdk';
import EventsRepository from "./../src/repositories/EventsRepository"

AWS.config.region = process.env.AWS_REGION || 'eu-west-2'
const eventBridge = new AWS.EventBridge()
const eventsRepository = new EventsRepository()

export async function sqsEventsRouter(event: SQSEvent) {
    try {
        for (const record of event.Records) {
            try {
                await eventsRepository.create({
                    id: record.messageId,
                    data: record.body
                })

                const source = record.eventSourceARN.split(":")
                const entry = {
                    EventBusName: 'default',
                    Source: record.eventSource,
                    DetailType: source[source.length - 1],
                    Detail: record.body,
                }

                await eventBridge.putEvents({ Entries: [entry] }).promise()
            } catch (error) {
                throw error
            }
        }

        return {};
    } catch (error) {
        console.log("Error on sqsEventsRouter");
        console.log(error);
        throw error
    }
}


exports.handler = sqsEventsRouter
