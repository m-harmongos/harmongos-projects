
import { DetailConstant } from '../../../common/CommonConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import CommonDialog from './CommonDialog';

@CustomDialog
export default struct IntervalDialog {
  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  @State intervalMinuteSelect: number = 0;
  @State intervalTimesSelect: number = 0;
  controller?: CustomDialogController;

  aboutToAppear(): void{
    this.intervalMinuteSelect = this.alarmItem.intervalMinute;
    this.intervalTimesSelect = this.alarmItem.intervalTimes;
  }

  build() {
    Flex() {
      if ((this.intervalTimesSelect | this.intervalMinuteSelect) > 0) {
        CommonDialog({
          title: '再响间隔',
          controller: this.controller,
          onConfirm: () => {
            this.alarmItem.intervalMinute = Number(this.intervalMinuteSelect.toFixed(0))
            this.alarmItem.intervalTimes = Number(this.intervalTimesSelect.toFixed(0))
          }
        }) {
          this.IntervalItem('响铃间隔时间（分钟）', 0)
          Divider()
            .opacity(0.05)
            .color('#182431')
            .lineCap(LineCapStyle.Round)
          this.IntervalItem('重复响铃次数', 1)
        }
      }
    }
  }

  @Builder IntervalItem(title: string | Resource, intervalType: number) {
    Text(title)
      .fontSize(10)
      .width('100%')
      .textAlign(TextAlign.Start)
      .margin({
        top: 10
      })
    Row() {
      Slider({
        value: (intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect),
        min: (intervalType === 0 ? 5 : 0),
        max: (intervalType === 0 ? 30 : 10),
        step: (intervalType === 0 ? 5 : 2),
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Blue)
        .trackColor(Color.Gray)
        .selectedColor(Color.Blue)
        .showSteps(true)
        .showTips(false)
        .onChange((value: number) => {
          if (intervalType === 0) {
            this.intervalMinuteSelect = value;
          } else {
            this.intervalTimesSelect = value;
          }
        })
      Text((intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect).toFixed(0))
        .fontSize(16)
    }
    .width('100%')
  }
}