<main>
    <Navbar/>
    <div class="flex justify-center h-auto p-20">
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 space-y-5 md:w-1/2 sm:w-full">
            <Combobox list="{languages}"
                      bind:selected={language}/>
            <TextBox label="Phrase to translate"
                     bind:value="{text}"/>
            <NumberInput label="Times to repeat"
                         bind:value={times}/>

            <button class="bg-blue-500 text-white font-bold py-2 px-4 rounded w-full
                           {loading === true ? 'opacity-50 cursor-not-allowed' : ''}"
                    on:click={translate}>
                Translate
            </button>
            {#if translated != null}
                <div class="bg-blue-100 border-t border-b border-blue-500 text-blue-700 px-4 py-3" role="alert">
                    <p class="font-bold">Translated text</p>
                    <p class="text-sm">{translated.transformedWord}</p>
                    <p></p>
                    <p class="font-bold">Translation path</p>
                    {#each translated.languages as language}
                        <p class="text-sm">{language}</p>
                    {/each}
                </div>
            {/if}
        </div>
    </div>
</main>

<script>
    import Navbar from "./Navbar.svelte";
    import TextBox from "./TextInput.svelte";
    import NumberInput from "./NumberInput.svelte";
    import {onMount} from 'svelte';
    import Combobox from "./Combobox.svelte";

    export let baseUrl

    let text;
    let times = 10;

    let translated
    let languages = {}
    let language = {}

    let loading = false

    onMount(async () => {
        const res = await fetch(baseUrl + '/randomTranslate');
        languages = await res.json();
        language = languages.find(element => element.code === 'en')
        console.log(languages)
    });

    async function translate() {
        console.log(language)
        loading = true
        if (times > 10)
            return
        const res = await fetch(baseUrl + '/randomTranslate', {
            method: 'POST',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                word: text,
                repeat: times,
                inputLanguageCode: language.code
            })
        })
        translated = await res.json()
        loading = false
        console.log(translated)
    }
</script>