// 时间提醒
import notificationManager from '@ohos.notificationManager'
import reminderAgentManager from '@ohos.reminderAgentManager';
import { CommonConstants } from '../common/CommonConstants';
import Logger from '../utils/Logger';
import ReminderItem from './ReminderItem';

export default class ReminderService {
  // 打开通知权限
  public openNotificationPermission() {
    notificationManager.requestEnableNotification().then(() => {
    Logger.info("Enable notification success");
    }).catch((err: Error) => {
      Logger.error('Enable notification failed because ' + JSON.stringify(err));
    })
  }

  // 初始化
  private initReminder(item: ReminderItem): reminderAgentManager.ReminderRequestAlarm {
    return {
      reminderType: item.remindType,
      hour: item.hour,
      minute: item.minute,
      daysOfWeek: item.repeatDays,
      title: item.name,
      ringDuration: item.duration * CommonConstants.DEFAULT_TOTAL_MINUTE,
      snoozeTimes: item.intervalTimes,
      timeInterval: item.intervalMinute * CommonConstants.DEFAULT_TOTAL_MINUTE,
      actionButton: [
        {
          title: '关闭',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE,
        },
        {
          title: '稍后提醒',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE,
        }
      ],
      wantAgent: {
        pkgName: CommonConstants.BUNDLE_NAME,
        abilityName: CommonConstants.ABILITY_NAME,
      },
      notificationId: item.notificationId,
      expiredContent: 'this reminder has expired',
      snoozeContent: 'remind later',
      slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION
    }
  }

  // 添加提醒
  public addReminder(alarmItem: ReminderItem, callback?: (reminderId: number) => void) {
    let reminder = this.initReminder(alarmItem);
    reminderAgentManager.publishReminder(reminder, (err, reminderId: number) => {
      if (callback) {
        callback(reminderId)
      }
    })
  }

  // 删除提醒
  public deleteReminder(reminderId: number) {
    reminderAgentManager.cancelReminder(reminderId);
  }
}