<script setup lang="ts">
import { DynamicFormInput } from "@/../../typings/dynamicFormInput";

defineProps({
  inputFields: {
    type: Array<DynamicFormInput>,
    required: true,
  },
});

const emits = defineEmits(["submit"]);

const formData: Record<string, unknown> = reactive({});

const onSubmit = () => {
  emits("submit", formData);
};
</script>

<template>
  <form>
    <div class="flex flex-col gap-4">
      <template v-for="field in inputFields" :key="field.key">
        <label class="font-medium text-gray-700">{{ field.label }}</label>
        <input
          v-if="!field.hidden"
          v-model="formData[field.key]"
          :type="field.type"
          :class="field.required ? 'is-required' : ''"
        />
      </template>

      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-medium px-4 py-2 rounded"
        @click="onSubmit(formData)"
      >
        Submit
      </button>
    </div>
  </form>
</template>
