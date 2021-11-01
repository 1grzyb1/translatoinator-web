<script>
    export let label
    export let value = ''
</script>

<main>
    <div class="w-full">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="{label}">
            {label}
        </label>
        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
               id="{label}" placeholder="{label}" bind:value="{value}">
    </div>
</main>