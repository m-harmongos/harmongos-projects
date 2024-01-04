import { DayDataItem, CommonConstants, DetailConstant, WeekDays } from '../common/CommonConstants';
import PreferencesHandler from '../model/database/PreferencesHandler';
import ReminderService from '../model/ReminderService';
import { GlobalContext } from '../utils/GlobalContext';
import AlarmItem from './AlarmItem';

export default class DetailViewModel {
  static instance: DetailViewModel = new DetailViewModel();
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  constructor() {
    this.reminderService = new ReminderService();
    this.alarms = new Array();
  }

  private getAlarmTime(aType: number): number {
    let times:DayDataItem = DetailConstant.DAY_DATA[aType];
    let selectedIndex = times.delSelect;
    let time = Number(times.data[selectedIndex]);
    if (aType === 1) {
      time = (time === 12 ? 0 : time)
      + (DetailConstant.DAY_DATA[0].delSelect === 1
        ? 12
        : 0);
    }
    return time;
  }

  public setAlarmDefaultTime(alarmItem?: AlarmItem) {
    let hour: number;
    let minute: number;
    if (alarmItem) {
      hour = alarmItem.hour;
      minute = alarmItem.minute;
    } else {
      let date = new Date();
      hour = date.getHours();
      minute = date.getMinutes();
    }
    DetailConstant.DAY_DATA[0].delSelect = hour >= 12 ? 1 : 0;
    DetailConstant.DAY_DATA[1].delSelect = (hour === 0 ? 12 : (hour > 12 ? hour - 12 : hour)) - 1;
    DetailConstant.DAY_DATA[2].delSelect = (minute === 0 ? 60 : minute) - 1;
  }

  // 设置闹钟提醒
  public async setAlarmRemind(alarmItem: AlarmItem) {
    alarmItem.hour = this.getAlarmTime(1);
    alarmItem.minute = this.getAlarmTime(2);
    let index = await this.findAlarmWithId(alarmItem.id);
    if (index !== -1) {
      this.reminderService.deleteReminder(alarmItem.id);
    } else {
      index = this.alarms.length;
      alarmItem.notificationId = index;
      this.alarms.push(alarmItem);
    }
    this.reminderService.addReminder(alarmItem, (newReminderId: number) => {
      alarmItem.id = newReminderId;
      alarmItem.isOpen = true;
      this.alarms[index] = alarmItem;
      let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
      if (preference) {
        preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
      }
    })
  }

  public async removeAlarmRemind(id: number) {
    this.reminderService.deleteReminder(id);
    let index = await this.findAlarmWithId(id);
    if (index !== -1) {
      this.alarms.splice(index, 1);
    }
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    if (preference) {
      preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
    }
  }

  public transAlarmRepeatDayContent(repeatDay: number): string {
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
    return repeatContent;
  }

  private async findAlarmWithId(id: number) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    if (preference) {
      let data = await preference.get(CommonConstants.ALARM_KEY);
      if (data) {
        this.alarms = JSON.parse(data);
        for (let i = 0; i < this.alarms.length; i++) {
          if (this.alarms[i].id === id) {
            return i;
          }
        }
      }
    }
    return -1;
  }

}