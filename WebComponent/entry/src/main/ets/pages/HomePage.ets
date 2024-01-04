@Entry
@Component
struct HomePage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Image($r('app.media.background'))
        .width('100%')
        .height('38.7%')
        .objectFit(ImageFit.Contain)
      Navigator({ target: 'pages/Index', type: NavigationType.Push }) {
        Button('Load the local H5')
          .fancy('4.6%')
      }
      .params({ path: $rawfile('index.html'), tips: '(Local)' })

      Navigator({ target: 'pages/Index', type: NavigationType.Push }) {
        Button('Load cloud H5')
          .fancy('3.1%')
      }
      .params({ path: 'https://www.baidu.com', tips: '(online)' })
    }
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Extend(Button) function fancy (top: string) {
  .fontSize(16)
  .fontColor(Color.Blue)
  .width('86.7%')
  .height('5.1%')
  .margin({ top: top })
  .backgroundColor('#F1F3F5')
  .borderRadius(20)
}