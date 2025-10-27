import web_webview from '@ohos.web.webview';
import router from '@ohos.router';

@Entry
@Component
struct NaWebViewPage {
  private controller: web_webview.WebviewController = new web_webview.WebviewController();
  
  // H5 HelloWorld 内容
  private htmlContent: string = `
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Hello World</title>
      <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        
        body {
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          min-height: 100vh;
          display: flex;
          justify-content: center;
          align-items: center;
          padding: 20px;
        }
        
        .container {
          text-align: center;
          background: white;
          padding: 60px 40px;
          border-radius: 20px;
          box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
          max-width: 600px;
          width: 100%;
          animation: fadeIn 0.6s ease-in-out;
        }
        
        @keyframes fadeIn {
          from {
            opacity: 0;
            transform: translateY(-20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        h1 {
          font-size: 48px;
          color: #333;
          margin-bottom: 20px;
          font-weight: 700;
        }
        
        .highlight {
          color: #667eea;
          animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
          0%, 100% {
            opacity: 1;
          }
          50% {
            opacity: 0.7;
          }
        }
        
        p {
          font-size: 18px;
          color: #666;
          line-height: 1.8;
          margin-bottom: 30px;
        }
        
        .button {
          display: inline-block;
          padding: 15px 40px;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          text-decoration: none;
          border-radius: 50px;
          font-size: 16px;
          font-weight: 600;
          transition: all 0.3s ease;
          border: none;
          cursor: pointer;
          box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }
        
        .button:hover {
          transform: translateY(-2px);
          box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }
        
        .button:active {
          transform: translateY(0);
        }
        
        .footer {
          margin-top: 40px;
          font-size: 14px;
          color: #999;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Hello <span class="highlight">World</span>!</h1>
        <p>欢迎来到HarmonyNext的Web组件世界</p>
        <p>这是一个通过本地HTML字符串加载的H5页面示例</p>
        <button class="button" onclick="handleClick()">点击我</button>
        <div class="footer">
          <p>Powered by HarmonyNext Web Component</p>
        </div>
      </div>
      
      <script>
        let clickCount = 0;
        
        function handleClick() {
          clickCount++;
          const messages = [
            '你好，HarmonyNext！',
            '这是第 ' + clickCount + ' 次点击',
            '继续探索吧！',
            '你真棒！',
            'Web组件很强大！'
          ];
          
          const randomMessage = messages[Math.floor(Math.random() * messages.length)];
          alert(randomMessage);
        }
        
        // 页面加载完成
        window.onload = function() {
          console.log('H5 HelloWorld页面加载完成');
        };
      </script>
    </body>
    </html>
  `;

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ left: 16 })
        Text('Native H5 页面')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .flexGrow(1)
          .textAlign(TextAlign.Center)
        Blank()
          .width(60)
      }
      .height(56)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.Gray)

      // WebView组件 - 加载本地HTML字符串
      Web({ src: 'data:text/html;charset=utf-8,' + encodeURIComponent(this.htmlContent), controller: this.controller })
        .width('100%')
        .height('100%')
        .javaScriptAccess(true)
        .domStorageAccess(true)
        .imageAccess(true)
        .onlineImageAccess(true)
        .onAlert((event) => {
          if (event) {
            AlertDialog.show({
              title: '提示',
              message: event.message,
              confirm: {
                value: '确定',
                action: () => {
                  event.result.handleConfirm();
                }
              }
            });
          }
          return true;
        })
    }
    .height('100%')
    .width('100%')
  }
}

