fn main() {
    let input = include_str!("../../input.txt");
    println!("Answer: {}", solution(input));
}

fn solution(input: &str) -> i32 {
    let mut total: i32 = 0;

    for line in input.lines() {
        let test = line
            .chars()
            .map(|c| c.to_digit(10).unwrap_or(10))
            .filter(|n| *n != 10)
            .collect::<Vec<u32>>();

        let first = test.first().unwrap().to_string();
        let last = test.last().unwrap().to_string();

        let number = format!("{}{}", first, last).parse::<i32>().unwrap();

        total += number;
    }

    return total;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = solution(
            "1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet",
        );
        assert_eq!(result, 142);
    }
}
