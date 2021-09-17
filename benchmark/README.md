# Benchmarks

Note: This code no longer works because adding `purescript-benchotron` to `bower.json`
prevents me from publishing this package. If you want to run the benchmarks, you will need to

1. Add `"purescript-benchotron": "master"` to the `bower.json`'s `devDependencies` field
2. Run `bower i`
3. Run `npm i benchmark.js`
4. Run `pulp run -I 'benchmark' -m Benchmark`
5. See the `benchmark-results` folder.
