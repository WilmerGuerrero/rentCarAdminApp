import { Makes, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Makes = await readBody(request);
    prisma.makes.update({
        data: body,
        where: {
            id: body.id
        }
    })
})