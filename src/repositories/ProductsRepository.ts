import { PutItemCommand, PutItemCommandInput } from "@aws-sdk/client-dynamodb";
import { Repository } from "./Repository";

type Product = {
    id: string;
    status: string;
    name: string;
  };

const enum ProductAttributs {
    id = "Id",
    idType = "S",
    name = "Name",
    nameType = "S",
    status = "Status",
    statusType = "S"
}

export default class ProductsRepository extends Repository {
    private readonly productsTable = "products-sandbox"

    create(product: Product){
        const params: PutItemCommandInput = {
            TableName: this.productsTable,
            Item: {
                [ProductAttributs.id]: {[ProductAttributs.idType]: product.id},
                [ProductAttributs.name]: {[ProductAttributs.nameType]: product.name},
                [ProductAttributs.status]: {[ProductAttributs.statusType]: product.status},
            }
          };

        this.client.send(new PutItemCommand(params))
    }
}
