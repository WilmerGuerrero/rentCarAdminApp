import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const { params } = request.context;
    prisma.makes.delete({
        where: {
            id: Number(params?.id)
        }
    })
})