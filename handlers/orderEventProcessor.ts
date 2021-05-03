import { EventBridgeEvent } from 'aws-lambda';
import OrdersRepository from "./../src/repositories/OrdersRepository"
const ordersRepository = new OrdersRepository()

export async function orderEventsProcessor(event: EventBridgeEvent<any, any>) {
    try {
        console.log(event.detail)
        await ordersRepository.create({
            id: event.detail.orderId,
            status: event.detail.status,
            totalPrice: event.detail.totalPrice,
        })
    } catch (error) {
        console.log("Error on orderEventsProcessor");
        console.log(error);
        throw error
    }

    return {};
}

exports.handler = orderEventsProcessor
