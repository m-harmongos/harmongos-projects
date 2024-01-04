import AlarmItem from '../../viewmodel/AlarmItem';
import MainModel from '../../viewmodel/MainViewModel';

@Preview
@Component
export default struct AlarmListItem {
  private mainModel: MainModel = MainModel.instance;
  private alarmItem: AlarmItem = new AlarmItem();

  build() {
    Row() {
      Column() {
        Row() {
          Text(this.mainModel.getNoonContent(this.alarmItem))
            .AlarmListItemCommonText(16, FontWeight.Regular)
          Text(this.mainModel.getTaskTimeContent(this.alarmItem.hour, this.alarmItem.minute))
            .AlarmListItemCommonText(24, FontWeight.Regular, { left: 4 })
        }
        Text(this.mainModel.getDescContent(this.alarmItem))
          .AlarmListItemCommonText(14, FontWeight.Normal, { top: 2 }, 0.6)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.alarmItem.isOpen })
        .onChange((isOn: boolean) => {
          this.mainModel.openAlarm(this.alarmItem.id, isOn);
        })
        .width(36)
        .height(20)
    }
    .padding({ left: 12, right: 12 })
    .backgroundColor(Color.White)
    .width('100%')
    .height(72)
    .borderRadius(24)
  }
}

@Extend(Text) function AlarmListItemCommonText(fontSize: number, fontWeight: number, margin?: Margin, opacity?: number) {
  .fontSize(fontSize)
  .fontColor('#182431')
  .fontWeight(fontWeight)
  .margin(margin ? margin: 0)
  .opacity(opacity ? opacity : 1)
}