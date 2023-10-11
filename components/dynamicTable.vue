<script setup lang="ts">
const { data, columns } = defineProps({
  columns: {
    type: Array<{ key: string; label: string }>,
    required: true,
  },
  data: {
    type: Array<any>,
    required: true,
  },
});

watch(data, (value, oldValue) => {
  console.log("table refreshed", oldValue, value);
  debugger;
});

const totalCount = ref(data.length);
const pageSize = 3;
const pages = ref(Math.ceil(totalCount.value / pageSize));
const currentPage = ref(1);

const canGoNext = computed(() => currentPage.value < pages.value);
const canGoPrev = computed(() => currentPage.value > 1);
const startIndex = computed(() => (currentPage.value - 1) * pageSize);
const endIndex = computed(() => startIndex.value + pageSize);
const filteredRecords = computed(() =>
  data.slice(startIndex.value, endIndex.value)
);

interface Record {
  [key: string]: string;
}

const goPrev = () => {
  if (canGoPrev.value) currentPage.value--;
};

const goNext = () => {
  if (canGoNext.value) currentPage.value++;
};

const emits = defineEmits(["delete-row", "modify-row"]);

const onDelete = (id: number) => {
  emits("delete-row", id);
};

const onModify = (item: Record) => {
  emits("modify-row", { ...item });
};
</script>

<template>
  <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
      >
        <tr>
          <th
            scope="col"
            class="px-6 py-3"
            v-for="(header, headerIndex) in columns"
            :key="`${header.key}-${headerIndex}`"
          >
            {{ header.label }}
          </th>
          <th scope="col" class="px-6 py-3"></th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600"
          v-for="(row, rowIndex) in filteredRecords"
          :key="`row-${rowIndex}`"
        >
          <th
            scope="row"
            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
            v-for="(column, columnIndex) in columns"
            :key="`row-${rowIndex}-column-${columnIndex}`"
          >
            {{ row[column.key] }}
          </th>

          <td>
            <button
              @click="onModify(row)"
              class="bg-gray-500 hover:bg-gray-700 text-white font-medium px-4 py-2 rounded mr-1"
            >
              Editar
            </button>
            <button
              @click="onDelete(row.id)"
              class="bg-red-500 hover:bg-red-700 text-white font-medium px-4 py-2 rounded"
            >
              Eliminar
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <nav
      class="flex items-center justify-between pt-4"
      aria-label="Table navigation"
    >
      <span class="text-sm font-normal text-gray-500 dark:text-gray-400"
        >Showing
        <span class="font-semibold text-gray-900 dark:text-white">1-10</span> of
        <span class="font-semibold text-gray-900 dark:text-white"
          >1000</span
        ></span
      >
      <ul class="inline-flex -space-x-px text-sm h-8">
        <li>
          <a
            href="#"
            class="flex items-center justify-center px-3 h-8 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400"
            :class="{
              'dark:hover:bg-gray-700': canGoPrev,
              'dark:hover:text-white': canGoPrev,
              'hover:bg-gray-100': canGoPrev,
              'hover:text-gray-700': canGoPrev,
            }"
            @click="goPrev"
          >
            Anterior
          </a>
        </li>
        <li>
          <a
            href="#"
            class="flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
          >
            {{ currentPage }}
          </a>
        </li>
        <li>
          <a
            href="#"
            class="flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400"
            :class="{
              'dark:hover:bg-gray-700': canGoNext,
              'dark:hover:text-white': canGoNext,
              'hover:bg-gray-100': canGoNext,
              'hover:text-gray-700': canGoNext,
            }"
            @click="goNext"
          >
            Siguiente
          </a>
        </li>
      </ul>
    </nav>
  </div>
</template>
