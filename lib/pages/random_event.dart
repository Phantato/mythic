import 'dart:math';

import 'package:flutter/material.dart';

class RandomEvent extends StatefulWidget {
  const RandomEvent({Key? key}) : super(key: key);
  @override
  _RandomEventState createState() => _RandomEventState();
}

class _RandomEventState extends State<RandomEvent> {
  static final random = Random();
  int focus = 0;
  int action = 0;
  int subject = 0;

  @override
  void initState() {
    super.initState();
    _generateEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: _generateEvent,
              child: Text('随机事件'),
            )),
        _Event(focus: focus, action: action, subject: subject),
      ],
    );
  }

  _generateEvent() {
    setState(() {
      focus = random.nextInt(100);
      action = random.nextInt(100);
      subject = random.nextInt(100);
    });
  }
}

class _Event extends StatelessWidget {
  const _Event({
    Key? key,
    required this.focus,
    required this.action,
    required this.subject,
  }) : super(key: key);

  final int focus, action, subject;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('事件焦点：${_transFocus(focus)}'),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('行动：${_transAction(action)}'),
                VerticalDivider(),
                Text('主题：${_transSubject(subject)}')
              ],
            )
          ],
        ));
  }

  static const _focus = [
    '远端事件',
    'NPC 行动',
    '新 NPC',
    '推进故事',
    '远离故事',
    '结束故事',
    'PC 负面',
    'PC 正面',
    '含糊不清',
    'NPC 负面',
    'NPC 正面',
  ];

  static const _action = [
    '成就',
    '开始',
    '忽视',
    '战斗',
    '招募',
    '胜利',
    '违反',
    '反对',
    '恶意',
    '沟通',
    '迫害',
    '增加',
    '减少',
    '放弃',
    '满足',
    '询问',
    '对抗',
    '移动',
    '浪费',
    '休战',
    '发布',
    '交友',
    '评判',
    '背弃',
    '支配',
    '拖延',
    '称赞',
    '分开',
    '拿取',
    '打破',
    '治愈',
    '延缓',
    '停止',
    '谎言',
    '返回',
    '模仿',
    '奋斗',
    '通知',
    '赐予',
    '推迟',
    '暴露',
    '还价',
    '监禁',
    '释放',
    '庆祝',
    '发展',
    '旅行',
    '阻塞',
    '伤害',
    '贬低',
    '放纵',
    '暂修',
    '逆境',
    '杀害',
    '打乱',
    '篡夺',
    '创造',
    '背叛',
    '同意',
    '虐待',
    '压迫',
    '检查',
    '伏击',
    '刺探',
    '附加',
    '携带',
    '打开',
    '粗心',
    '毁坏',
    '奢侈',
    '唬骗',
    '到达',
    '提议',
    '划分',
    '拒绝',
    '怀疑',
    '欺骗',
    '残忍',
    '不容忍',
    '信任',
    '兴奋',
    '活动',
    '协助',
    '关怀',
    '疏忽',
    '激情',
    '努力',
    '控制',
    '吸引',
    '失败',
    '追求',
    '复仇',
    '诉讼',
    '争议',
    '惩罚',
    '指导',
    '变换',
    '推翻',
    '压迫',
    '改变',
  ];

  static const _subject = [
    '目标',
    '梦想',
    '环境',
    '外面',
    '内部',
    '现实',
    '盟友',
    '敌人',
    '邪恶',
    '善良',
    '情绪',
    '反对',
    '战争',
    '和平',
    '无辜的',
    '爱',
    '精神',
    '知识分子',
    '新想法',
    '喜悦',
    '消息',
    '能源',
    '平衡',
    '紧张',
    '友谊',
    '物理',
    '一个项目',
    '快乐',
    '疼痛',
    '财产',
    '好处',
    '计划',
    '谎言',
    '期望',
    '法律事务',
    '官僚主义',
    '商业',
    '一条路',
    '新闻',
    '外部因素',
    '忠告',
    '一个情节',
    '竞争',
    '监狱',
    '疾病',
    '食物',
    '注意',
    '成功',
    '失败',
    '旅行',
    '嫉妒',
    '争议',
    '家',
    '投资',
    '苦难',
    '愿望',
    '战术',
    '僵局',
    '随机性',
    '不幸',
    '死亡',
    '中断',
    '权力',
    '负担',
    '阴谋',
    '恐惧',
    '伏击',
    '谣言',
    '伤口',
    '奢侈',
    '代表',
    '逆境',
    '富裕',
    '自由',
    '军事',
    '世俗',
    '审判',
    '弥撒',
    '车辆',
    '艺术',
    '胜利',
    '争议',
    '财富',
    '现状',
    '技术',
    '希望',
    '魔法',
    '幻觉',
    '传送门',
    '危险',
    '武器',
    '动物',
    '天气',
    '元素',
    '自然',
    '公众',
    '领导力',
    '名气',
    '愤怒',
    '信息',
  ];

  String _transFocus(int focus) {
    if (focus < 53) {
      if (focus < 29) {
        if (focus < 8) {
          return _focus[0];
        } else {
          return _focus[1];
        }
      } else if (focus < 46) {
        if (focus < 36) {
          return _focus[2];
        } else {
          return _focus[3];
        }
      } else {
        return _focus[4];
      }
    } else if (focus < 76) {
      if (focus < 68) {
        if (focus < 56) {
          return _focus[5];
        } else {
          return _focus[6];
        }
      } else {
        return _focus[7];
      }
    } else if (focus < 93) {
      if (focus < 84) {
        return _focus[8];
      } else {
        return _focus[9];
      }
    } else {
      return _focus[10];
    }
  }

  String _transAction(int action) => _action[action];
  String _transSubject(int subject) => _subject[subject];
}
