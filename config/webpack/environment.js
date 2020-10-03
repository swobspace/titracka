const { environment } = require('@rails/webpacker')
const webpack = require('webpack');

const erb = require('./loaders/erb')
const coffee =  require('./loaders/coffee')

environment.loaders.prepend('coffee', coffee)
environment.loaders.prepend('erb', erb)

environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        Popper: ['popper.js', 'default']
    })
);

module.exports = environment
