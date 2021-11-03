<main>
    <link href="https://cdn.jsdelivr.net/npm/@tailwindcss/custom-forms@0.2.1/dist/custom-forms.css"
          rel="stylesheet"
    />

    <label class="block text-gray-700 text-sm font-bold mb-2">
        <span class="text-gray-700">Select default language</span>
        <select class="form-select block w-full mt-1" bind:value={selected}>
            {#each list as item}
                <option value="{item}" class="text-gray-700">{item.name}</option>
            {/each}
        </select>
    </label>
</main>

<script>
    export let list
    export let selected
</script>