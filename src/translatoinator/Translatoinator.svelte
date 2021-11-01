<main>
    <Navbar/>
    <div class="flex justify-center h-auto p-20">
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 w-1/2 space-y-5">
            <TextBox label="Phrase to translate"
                     bind:value="{text}"/>
            <NumberInput label="Times to repeat"
                         bind:value={times}/>
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded w-full" on:click={translate}>
                Translate
            </button>
            {#if response != null}
                <div class="bg-blue-100 border-t border-b border-blue-500 text-blue-700 px-4 py-3" role="alert">
                    <p class="font-bold">Translated text</p>
                    <p class="text-sm">{response}</p>
                </div>
            {/if}
        </div>
    </div>
</main>

<script>
    import Navbar from "./Navbar.svelte";
    import TextBox from "./TextInput.svelte";
    import NumberInput from "./NumberInput.svelte";

    export let baseUrl

    let text;
    let times;

    let response

    async function translate() {
        const res = await fetch(baseUrl + '/randomTranslate', {
            method: 'POST',
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                word: text,
                repeat: times
            })
        })
        response = await res.text()
    }
</script>