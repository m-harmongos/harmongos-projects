import reminderAgentManager from '@ohos.reminderAgentManager';

export default class ReminderItem {
  id: number = 0;
  remindType: reminderAgentManager.ReminderType = reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM;
  name: string = ''; // 提醒名称
  hour: number = 0;
  minute: number = 0;
  duration: number = 0; // 提醒持续时间
  intervalMinute: number = 0; // 延迟提醒间隔,单位秒
  intervalTimes: number = 0; // 延迟提醒次数
  repeatDays: Array<number> = []; // 重复
  notificationId: number = 0; // 通知ID
}