fn main() {
    let input: &str = include_str!("../../input.txt");
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

        println!("{:?} ", test);

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
            "two1nine
            eightwothree
            abcone2threexyz
            xtwone3four
            4nineeightseven2
            zoneight234
            7pqrstsixteen",
        );
        assert_eq!(result, 281);
    }
}
