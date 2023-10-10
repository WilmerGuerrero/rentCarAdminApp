<script setup lang="ts">

const emits = defineEmits(['click'])

const onClick = () => {
    emits('click')
}
</script>

<template>
    <button
        :class="{ 
            'form-button': true, 
            'w-full': true, 
        }"
        @click="onClick"
    ></button>
</template>