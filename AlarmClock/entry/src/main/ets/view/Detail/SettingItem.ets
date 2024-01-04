import { AlarmSettingType } from '../../common/CommonConstants';
import AlarmSettingItem from '../../viewmodel/AlarmSettingItem';
import DurationDialog from './dialog/DurationDialog';
import IntervalDialog from './dialog/IntervalDialog';
import RenameDialog from './dialog/RenameDialog';
import RepeatDialog from './dialog/RepeatDialog';

@Component
export default struct SettingItem {
  @Link settingInfo: Array<AlarmSettingItem>;
  repeatDialogController: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });
  reNameDialogController: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });
  durationDialogController: CustomDialogController = new CustomDialogController({
    builder: DurationDialog(),
    autoCancel: true
  });
  intervalDialogController: CustomDialogController = new CustomDialogController({
    builder: IntervalDialog(),
    autoCancel: true
  });

  private showSettingDialog(sType: AlarmSettingType) {
    switch (sType) {
      case AlarmSettingType.REPEAT:
        this.repeatDialogController.open();
        break;
      case AlarmSettingType.ALARM_NAME:
        this.reNameDialogController.open();
        break;
      case AlarmSettingType.RING_DURATION:
        this.durationDialogController.open();
        break;
      case AlarmSettingType.INTERVAL:
        this.intervalDialogController.open();
        break;
      default:
        break
    }
  }

  build() {
    Column() {
      ForEach(this.settingInfo, (item: AlarmSettingItem, index: number | undefined) => {
        Divider()
          .visibility(index === 0 ? Visibility.Hidden : Visibility.Visible)
          .opacity(0.05)
          .color('#182431')
          .lineCap(LineCapStyle.Round)
          .margin({
            left: 12,
            right: 12
          })
        Row() {
          Text(item.title)
            .fontSize(16)
            .fontWeight(FontWeight.Regular)
            .fontColor('#182431')
            .layoutWeight(1)
          Text(item.content)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#182431')
            .opacity(0.6)
          Image($r('app.media.ic_right'))
            .width(6.7)
            .height(12.8)
            .objectFit(ImageFit.Fill)
            .margin({
              left: 7
            })
        }
        .height(56)
        .alignItems(VerticalAlign.Center)
        .padding({
          left: 12,
          right: 12
        })
        .onClick(() => {
          this.showSettingDialog(item.sType);
        })
      }, (item: AlarmSettingItem, index: number | undefined) => JSON.stringify(item) + index)
    }
    .margin({ top: 12, left: 12, right: 12 })
    .borderRadius(24)
    .backgroundColor(Color.White)
  }
}