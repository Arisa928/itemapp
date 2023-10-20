module.exports = function(api) {
  api.cache(true);
  // 基本のBabel設定
  const basePresets = [
    [
      '@babel/preset-env',
      {
        forceAllTransforms: true,
        useBuiltIns: 'entry',
        corejs: 3,
        modules: false,
        exclude: ['transform-typeof-symbol']
      }
    ]
  ];
  const basePlugins = [
    'babel-plugin-macros',
    '@babel/plugin-syntax-dynamic-import',
    '@babel/plugin-transform-destructuring',
    [
      '@babel/plugin-transform-class-properties',
      {
        loose: true
      }
    ],
    [
      '@babel/plugin-transform-object-rest-spread',
      {
        useBuiltIns: true
      }
    ],
    // 他のプラグイン...
  ];
  // 新しい設定
  const newPresets = ["@babel/preset-env"];
  // 元の設定と新しい設定をマージ
  const presets = [...basePresets, ...newPresets];
  const plugins = basePlugins;
  return {
    presets,
    plugins,
  };
};
