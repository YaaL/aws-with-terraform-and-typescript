import { EventBridgeEvent } from 'aws-lambda';

export async function productEventsProcessor (event: EventBridgeEvent<any, any>){
    console.log("hello Alban");
    console.log(event);
}

exports.handler = productEventsProcessor
