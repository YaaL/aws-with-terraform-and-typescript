import { EventBridgeEvent } from 'aws-lambda';

export async function  allEventsProcessor (event: EventBridgeEvent<any, any>) {
    console.log(event);
    return event
}

exports.handler = allEventsProcessor
