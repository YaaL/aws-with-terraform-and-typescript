import { EventBridgeEvent } from 'aws-lambda';
import ProductsRepository from "./../src/repositories/ProductsRepository"
const productsRepository = new ProductsRepository()

export async function productEventsProcessor(event: EventBridgeEvent<any, any>) {

    try {
        console.log(event.detail)
        await productsRepository.create({
            id: event.detail.productId,
            categoryId: event.detail.categoryId,
            name: event.detail.name,
            status: event.detail.status
        })
    } catch (error) {
        console.log("Error on productEventsProcessor");
        console.log(error);
        throw error
    }

    return {};
}

exports.handler = productEventsProcessor
