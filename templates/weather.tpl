<!DOCTYPE html>
<html mip>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
    <title>天气预报 MIP 页</title>
    <link rel="canonical" href="对应的原页面地址">
    <link rel="stylesheet" href="https://c.mipcdn.com/static/v2/mip.css">
    <style mip-custom>
      /* 自定义样式 */
      h2 {
        margin: 50px auto;
        text-align: center;
      }
      p, span {
        margin-left: 20px;
      }
      p {
        font-weight: bold
      }
    </style>
  </head>
  <body>
    <mip-example></mip-example>
    <div class="forecast-wrapper">
      <h2>下面为您播报天气预报</h2>
      <p>上海：<%= temp %>℃，<%= text %></p>
      <span>（更新于 <%= date %>）</span>
    </div>
    <script src="https://c.mipcdn.com/static/v2/mip.js"></script>
    <script src="/mip-example/mip-example.js"></script>
  </body>
</html>
