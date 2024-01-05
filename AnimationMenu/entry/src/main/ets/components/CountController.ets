@Component
export default struct CountController {
  @Link quantity: number;

  build() {
    Column() {
      Row() {
        Text('数量')
          .textStyle()

        Text(this.quantity.toFixed(0))
          .textStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 4 })

      Slider({
        value: this.quantity,
        min: 3,
        max: 6,
        step: 1,
        style: SliderStyle.InSet
      })
        .blockColor(Color.White)
        .selectedColor('#007DFF')
        .margin({ top: 5 })
        .showSteps(true)
        .trackThickness(20)
        .onChange((value: number) => {
          this.quantity = value;
        })
    }
    .height(97)
    .padding({ top: 12, bottom: 12, left: 16, right: 16 })
    .margin({ bottom: 48 })
    .width(336)
    .borderRadius(24)
    .backgroundColor('#FFFFFF')
  }
}

@Extend(Text) function textStyle () {
  .fontSize(16)
  .fontWeight(500)
}