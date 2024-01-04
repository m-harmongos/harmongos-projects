import router from '@ohos.router';
import AlarmList from '../view/Main/AlarmList';
import ClockArea from '../view/Main/ClockArea';
import AlarmItem from '../viewmodel/AlarmItem';
import MainModel from '../viewmodel/MainViewModel';

@Entry
@Component
struct Index {
  private mainModel: MainModel = MainModel.instance;
  @State alarmItems: Array<AlarmItem> = new Array();
  @State isAUth: boolean = false;

  aboutToAppear() {
    this.mainModel.queryAlarmsTasker((alarms: Array<AlarmItem>) => {
      this.alarmItems = alarms;
    })
  }

  build() {
    Column() {
      Text('闹钟')
        .height(56)
        .textAlign(TextAlign.Start)
        .fontSize(24)
        .width('100%')
        .fontColor(0x182431)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
        .padding({ left: 24 })
      ClockArea()

      AlarmList({ alarmItems: $alarmItems })

      Blank()

      Button() {
        Image($r('app.media.ic_add')).objectFit(ImageFit.Fill)
      }
      .backgroundColor(Color.Black)
      .width(48)
      .aspectRatio(1)
      .margin({ bottom: 24, top: 24 })
      .onClick(() => {
        router.pushUrl({ url: 'pages/DetailIndex' })
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}