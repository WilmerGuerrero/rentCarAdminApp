<script setup lang="ts">
import { DynamicFormInput } from "@/../../typings/dynamicFormInput";
const { formData } = defineProps({
  inputFields: {
    type: Array<DynamicFormInput>,
    required: true,
  },
  formData: {
    type: Object,
    required: true,
  },
});

const dropdown = resolveComponent("FormInputsDropdown");
const emits = defineEmits(["submit"]);

const onSubmit = () => {
  console.log("submitting", formData);

  emits("submit", formData);
};

onMounted(() => {
  console.log("mounted", formData);
});
</script>

<template>
  <form>
    <div class="flex flex-col gap-4">
      <template v-for="field in inputFields" :key="field.key">
        <label class="font-medium text-gray-700" v-if="!field.hidden">{{
          field.label
        }}</label>
        <!-- <input
          v-if="!field.hidden"
          v-model="formData[field.key]"
          :type="field.type"
          :class="field.required ? 'is-required' : ''"
        /> -->
        {{ field?.values }}
        <component
          :is="field.type == 'dropdown' ? dropdown : field.type"
          :id="field.key"
          v-if="!field.hidden"
          v-model="formData[field.key]"
          :required="field.required"
          :values="field.values"
          @onChange="($event: {}) => console.log('event', $event)"
          class="mb-4"
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
