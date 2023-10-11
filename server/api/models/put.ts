import { PrismaClient } from "@prisma/client";
import { Models } from "~/typings/models";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Models = await readBody(request);    
    const upsertedModel = await prisma.models.upsert({
        where: {
            name: body.name
        },
        create: body,
        update: body
    });

    return {
        statusCode: 200,
        upsertedModel
    }
})