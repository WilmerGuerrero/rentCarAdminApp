<script setup>

const props = defineProps({
    isRequired: Boolean,
    model: {
        type: String,
        required: isRequired
    }
})

</script>

<template>
    <input 
        type="text"
        :class="{ 
            'form-input': true, 
            'w-full': true ,
            'is-required': isRequired
        }"
        v-model="model"
        :required="isRequired"
    />
  </template>
  