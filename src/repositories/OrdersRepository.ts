import { PutItemCommand, PutItemCommandInput } from "@aws-sdk/client-dynamodb";
import { Repository } from "./Repository";

type Order = {
    id: string;
    status: string;
    totalPrice: number;
};

const enum OrderAttributes {
    id = "Id",
    idType = "S",
    status = "Status",
    statusType = "S",
    totalPrice = "TotalPrice",
    totalPriceType = "N"
}

export default class OrderRepository extends Repository {
    private readonly productsTable = "orders-sandbox"

    async create(product: Order) {
        const params: PutItemCommandInput = {
            TableName: this.productsTable,
            Item: {
                [OrderAttributes.id]: { [OrderAttributes.idType]: product.id },
                [OrderAttributes.status]: { [OrderAttributes.statusType]: product.status },
                [OrderAttributes.totalPrice]: { [OrderAttributes.totalPriceType]: `${product.totalPrice}` },
            }
        };

        await this.client.send(new PutItemCommand(params))
    }
}
