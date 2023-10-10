import { Clients, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Clients = await readBody(request);
    prisma.clients.update({
        data: body,
        where: {
            userId: body.userId
        }
    })
})