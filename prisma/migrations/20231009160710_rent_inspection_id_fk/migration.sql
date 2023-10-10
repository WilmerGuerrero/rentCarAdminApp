/*
  Warnings:

  - Added the required column `inspectionId` to the `Rents` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Rents" ADD COLUMN     "inspectionId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Rents" ADD CONSTRAINT "Rents_inspectionId_fkey" FOREIGN KEY ("inspectionId") REFERENCES "Inspections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
