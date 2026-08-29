<?php
global $village, $database, $session, $technology, $id;

$trainingSchedules = $database->getTrainingSchedules((int)$village->wid, (int)$session->uid);
if (!empty($trainingSchedules)):
    $scheduleNames = [
        19 => defined('BARRACKS') ? BARRACKS : 'Barracks',
        20 => defined('STABLE') ? STABLE : 'Stable',
        21 => defined('WORKSHOP') ? WORKSHOP : 'Workshop',
        29 => defined('GREATBARRACKS') ? GREATBARRACKS : 'Great Barracks',
        30 => defined('GREATSTABLE') ? GREATSTABLE : 'Great Stable'
    ];
?>
<table cellpadding="1" cellspacing="1" class="under_progress training_schedule">
    <thead><tr><td colspan="3"><?php echo defined('SCHEDULE_TRAINING') ? SCHEDULE_TRAINING : 'Scheduled training'; ?></td></tr></thead>
    <tbody>
    <?php foreach ($trainingSchedules as $schedule): ?>
        <tr>
            <td><?php echo htmlspecialchars($scheduleNames[(int)$schedule['building']] ?? 'Training'); ?></td>
            <td><?php echo (int)$schedule['amt']; ?> × <?php echo htmlspecialchars($technology->getUnitName((int)$schedule['unit'])); ?></td>
            <td>
                <form method="POST" action="build.php">
                    <input type="hidden" name="id" value="<?php echo (int)$id; ?>" />
                    <input type="hidden" name="schedule_delete" value="<?php echo (int)$schedule['id']; ?>" />
                    <button type="submit"><?php echo defined('DELETE') ? DELETE : 'Delete'; ?></button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>
