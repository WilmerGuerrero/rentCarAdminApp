import { Models, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Models = await readBody(request);
    prisma.models.update({
        data: body,
        where: {
            id: body.id
        }
    })
})