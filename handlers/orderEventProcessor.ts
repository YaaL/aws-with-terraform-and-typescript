import { EventBridgeEvent } from 'aws-lambda';

export async function orderEventsProcessor (event: EventBridgeEvent<any, any>) {
    console.log(event);
}

exports.handler = orderEventsProcessor
