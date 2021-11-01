<script>
    export let label
    export let value = 0
</script>

<main>
    <div class="w-full">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="{label}">
            {label}
        </label>
        {#if value > 10}
            <div class="text-red-600">
                Value must be less or equal than 10
            </div>
        {/if}
        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                        {value > 10 ? 'border-red-600' : ''}"
               id="{label}" placeholder="{label}" bind:value="{value}">
    </div>
</main>