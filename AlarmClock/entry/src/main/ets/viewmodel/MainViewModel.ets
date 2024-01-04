import { CommonConstants, WeekDays } from '../common/CommonConstants';
import PreferencesHandler from '../model/database/PreferencesHandler';
import PreferencesListener from '../model/database/PreferencesListener';
import ReminderService from '../model/ReminderService';
import { GlobalContext } from '../utils/GlobalContext';
import AlarmItem from './AlarmItem';

export default class MainViewModel {
  static instance: MainViewModel = new MainViewModel();
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  private constructor() {
    this.alarms = new Array();
    this.reminderService = new ReminderService();
    // 请求提醒权限
    this.reminderService.openNotificationPermission();
  }

  // 查询提醒任务列表
  private queryDatabaseAlarms(callback: (alarms: Array<AlarmItem>) => void) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    if (preference) {
      preference.get(CommonConstants.ALARM_KEY).then((data: string) => {
        if (data) {
          this.alarms = JSON.parse(data);
          callback(this.alarms);
        }
      });
    }
  }

  // 查询提醒任务监听者
  public queryAlarmsTasker(callback: (alarms: Array<AlarmItem>) => void) {
    this.queryDatabaseAlarms(callback);
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    if (preference) {
      preference.addPreferencesListener({
        onDataChanged: () => {
          this.queryDatabaseAlarms(callback);
        }
      } as PreferencesListener);
    }
  }

  // 时间填充0
  public fillZero(val: number): string {
    return val > 9 ? val.toString() : `0${val}`
  }

  // 获取任务提醒时间内容
  public getTaskTimeContent(hour: number, minute: number): string {
    return this.fillZero(hour > 12 ? hour - 12 : 12) + ':' + this.fillZero(minute);
  }

  // 打开提醒
  public openAlarm(id: number, isOpen: boolean) {
    for (let i = 0; i < this.alarms.length; i++) {
      if (this.alarms[0].id === id) {
        this.alarms[i].isOpen = isOpen;
        if (isOpen) {
          this.reminderService.addReminder(this.alarms[i]);
        } else {
          this.reminderService.deleteReminder(id);
        }
        // 存储到本地
        let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
        if (preference) {
          preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
        }
        break;
      }
    }
  }

  public getDescContent(alarmItem: AlarmItem): string {
    return alarmItem.name + ', ' + (alarmItem.isRepeat ? this.getAlarmRepeatDayContent(alarmItem) : '不重复');
  }

  public getAlarmRepeatDayContent(alarmItem: AlarmItem): string {
    let content = '';
    for (let i = 0; i < alarmItem.repeatDays.length; i++) {
      let repeatDay = alarmItem.repeatDays[i];
      let repeatContent = '周一';
      switch (repeatDay) {
        case WeekDays.DEFAULT_NUMBER_MONDAY:
          repeatContent = '周一';
          break;
        case WeekDays.DEFAULT_NUMBER_TUESDAY:
          repeatContent = '周二';
          break;
        case WeekDays.DEFAULT_NUMBER_WEDNESDAY:
          repeatContent = '周三';
          break;
        case WeekDays.DEFAULT_NUMBER_THURSDAY:
          repeatContent = '周四';
          break;
        case WeekDays.DEFAULT_NUMBER_FRIDAY:
          repeatContent = '周五';
          break;
        case WeekDays.DEFAULT_NUMBER_SATURDAY:
          repeatContent = '周六';
          break;
        case WeekDays.DEFAULT_NUMBER_SUNDAY:
          repeatContent = '周日';
          break;
        default:
          break;
      }
      content += repeatContent + ' ';
    }
    return content;
  }


  public getNoonContent(alarmItem: AlarmItem): string {
    return alarmItem.hour < 12 ? '上午' : '下午';
  }
}